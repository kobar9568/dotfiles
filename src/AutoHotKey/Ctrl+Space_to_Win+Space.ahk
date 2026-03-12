;; Avoid Ctrl getting stuck in down state, even when not physically pressed:
A_MenuMaskKey := "vkFF"
^Space::Send("#{Space}")
