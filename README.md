conformlog is a library for certification and reasoning about important inequalities, theorems and programs which arise in control theory. This framework was written in Minlog, an interactive proof system developed by Helmut Schwichtenberg and uses the Minlog's theory of constructive real analysis which aims for the certified program extraction. It was also inspired by Coq-CoRN code repository. conformlog adds aditional theorems and extends the functionality of the base system. At the current stage we support:

    Coninuous multivariate and vector-valued functions and their correct approximations
    Certification of positive definite functions
    Lyapunov stability theorem for discrete-time systems 

System Requirements

    Chez Scheme 9.5
    Optional: text editor with integrated Terminal (i.e. Emacs or Visual Studio Code)

Installation Instruction

    "./install.sh"
    Run Minlog: "scheme init.scm"
    Load: (minlog-load "./" "sys_us.scm")
    


