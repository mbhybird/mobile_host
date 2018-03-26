//
//  ParallaxViewControllerAnimator.swift
//  DGParallaxViewControllerTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

enum ParallaxViewControllerAnimatorState {
    case presenting
    case dismissing
}

class ParallaxViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private(set) var state: ParallaxViewControllerAnimatorState
    public var viewScale: CGFloat

    public init(state: ParallaxViewControllerAnimatorState) {
        self.state = state
        self.viewScale = 1
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.state == .presenting {
            self.presentingTransition(using: transitionContext)
        } else {
            self.dismissingTransition(using: transitionContext)
        }
    }

    private func presentingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromView = fromViewController.view,
            let toView = toViewController.view
            else {
                return
        }
        let containerView = transitionContext.containerView
        let toFinalFrame = transitionContext.finalFrame(for: toViewController)
        toView.frame = toFinalFrame.offsetBy(dx: 0, dy: toFinalFrame.maxY)
        containerView.addSubview(toView)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            toView.frame = toFinalFrame
            fromView.transform = CGAffineTransform.scaledBy(.identity)(x: strongSelf.viewScale, y: strongSelf.viewScale)
        }) { (finished) in
            let cancelled = transitionContext.transitionWasCancelled
            let completed = finished && !cancelled
            transitionContext.completeTransition(completed)
        }
    }

    private func dismissingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromView = fromViewController.view,
            let toView = toViewController.view,
            let snapshotView = toView.snapshotView(afterScreenUpdates: true)
            else {
                return
        }
        let containerView = transitionContext.containerView
        let fromFinalFrame = transitionContext.finalFrame(for: fromViewController)
        let finalFrame = fromFinalFrame.offsetBy(dx: 0, dy: fromView.frame.maxY)
        snapshotView.frame = containerView.frame
        snapshotView.transform = toView.transform
        containerView.insertSubview(snapshotView, at: 0)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            fromView.frame = finalFrame
            snapshotView.transform = CGAffineTransform.scaledBy(.identity)(x: strongSelf.viewScale, y: strongSelf.viewScale)
        }) { [weak self] (finished) in
            guard let strongSelf = self else {
                return
            }
            let cancelled = transitionContext.transitionWasCancelled
            let completed = finished && !cancelled
            transitionContext.completeTransition(completed)
            snapshotView.removeFromSuperview()
            if completed {
                toView.transform = CGAffineTransform.scaledBy(.identity)(x: strongSelf.viewScale, y: strongSelf.viewScale)
            }
        }
    }
}
