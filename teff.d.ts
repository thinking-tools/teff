/**
 * Type declarations for @thinking.tools/teff.
 * The JS bundle is an IIFE: importing the package registers the custom
 * elements and installs the `teff` global as side effects.
 */

export type ToastVariant = "info" | "success" | "warning" | "danger";

export type ToastPlacement =
  | "top-left"
  | "top-center"
  | "top-right"
  | "bottom-left"
  | "bottom-center"
  | "bottom-right";

export interface ToastShowOptions {
  /** Where the toast stack appears. Default: "top-right". */
  placement?: ToastPlacement;
  /** Auto-dismiss after this many ms; 0 disables auto-dismiss. Default: 4000. */
  duration?: number;
}

export interface ToastOptions extends ToastShowOptions {
  /** Visual tone of the toast. Default: "info". */
  variant?: ToastVariant;
}

export interface ToastFn {
  /** Show a text toast. Returns the created toast element. */
  (message: string, title?: string, options?: ToastOptions): HTMLOutputElement;
  /**
   * Show an element as a toast. A `<template>` contributes its first child;
   * any other element is cloned. Returns the shown element, or undefined if
   * there was nothing to show.
   */
  el(el: Element, options?: ToastShowOptions): HTMLElement | undefined;
  /** Dismiss all toasts, or only those in the given placement. */
  clear(placement?: ToastPlacement): void;
}

export interface Teff {
  toast: ToastFn;
  /**
   * Play the [data-shake] attention animation on an element. Safe to call
   * repeatedly; restarts a mid-flight animation. No-op when el is null.
   */
  shake(el: Element | null): void;
}

export interface TeffTabChangeDetail {
  /** Zero-based index of the newly active tab. */
  index: number;
  /** The activated [role="tab"] element. */
  tab: HTMLElement;
}

/**
 * `<teff-tabs>` — wires ARIA and arrow-key navigation around child
 * [role="tablist"]/[role="tab"]/[role="tabpanel"] markup.
 * Emits "teff-tab-change" (bubbling) on activation.
 */
export declare class TeffTabs extends HTMLElement {
  /** Zero-based index of the active tab. Setting it activates that tab. */
  activeIndex: number;
}

/**
 * `<teff-dropdown>` — anchors a child [popover] menu to its
 * [popovertarget] trigger and adds menu keyboard navigation.
 */
export declare class TeffDropdown extends HTMLElement {}

declare global {
  /** Installed by the teff JS bundle. */
  var teff: Teff;

  interface Window {
    teff: Teff;
  }

  interface HTMLElementTagNameMap {
    "teff-tabs": TeffTabs;
    "teff-dropdown": TeffDropdown;
  }

  interface GlobalEventHandlersEventMap {
    "teff-tab-change": CustomEvent<TeffTabChangeDetail>;
  }
}
