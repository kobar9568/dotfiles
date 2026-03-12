;; Avoid Ctrl getting stuck in down state, even when not physically pressed:
A_MenuMaskKey := "vkFF"
!h::Send("{Left}")
!j::Send("{Down}")
!k::Send("{Up}")
!l::Send("{Right}")
