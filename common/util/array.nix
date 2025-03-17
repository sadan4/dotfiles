{ lib, ... }:
{
  array = rec {
    popHead = list: lib.lists.ifilter0 (index: _element: index != 0) list;
    popTail = list: lib.lists.ifilter0 (index: _element: index - 1 != length list) list;
    head = list: at 0 list;
    tail = list: at (length list - 1) list;
    at = index: list: builtins.elemAt list index;
    length = list: builtins.length list;
  };
}
