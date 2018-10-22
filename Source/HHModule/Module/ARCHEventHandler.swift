//
//  ARCHEventHandler.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

open class ARCHStateHandler<T> {
    public let block: (T, T) -> T?
    public var currentState: T?

    public init(block: @escaping (T, T) -> T?) {
        self.block = block
    }

    open func willUpdate(state: T, newState: T) {
        currentState = block(state, newState)
    }
}

open class ARCHEventHandler<State: ARCHState>: ACRHViewOutput {
    public weak var router: ARCHRouter?
    public weak var viewInput: ARCHViewInput?
    public var stateHandler: ARCHStateHandler<State>?

    private var ignoreStateChanges: Bool = false

    public init() {}

    public var state: State = State() {
        willSet {
            stateHandler?.willUpdate(state: state, newState: newValue)
        }
        didSet {
            if let state = stateHandler?.currentState {
                self.state = state
            }

            viewSetNeedsRedraw()
        }
    }

    open func beginStateChanges() {
        ignoreStateChanges = true
    }

    open func commitStateChanges() {
        ignoreStateChanges = false
        viewSetNeedsRedraw()
    }

    open func updateState(_ block: () -> Void) {
        beginStateChanges()
        block()
        commitStateChanges()
    }

    // MARK: - ACRHViewOutput

    open func viewIsReady() {
        viewSetNeedsRedraw()
    }

    open func viewSetNeedsRedraw() {
        if !ignoreStateChanges {
            viewInput?.update(state: state)
        }
    }

    open func shouldRender(_ state: Any) -> Bool {
        guard let state = state as? State, self.state.id == state.id else {
            return false
        }

        ignoreStateChanges = true
        self.state = state
        ignoreStateChanges = false

        return true
    }
}
