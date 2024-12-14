function fish_user_key_bindings
    bind -M insert jj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
    bind \cg do_ctrl_g
    bind -M insert \cg do_ctrl_g
    bind \el accept-autosuggestion
    bind -M insert \el accept-autosuggestion
end
