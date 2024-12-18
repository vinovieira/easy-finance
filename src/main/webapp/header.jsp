<nav class="navbar border-bottom border-body navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp"><i class="fa-light fa-file-invoice-dollar"></i> EasyFinance</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="dashboard?action=list">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="expense?action=list">Despesas</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="income?action=list">Receitas</a>
                </li>
            </ul>
            <c:if test="${empty user }">
               <span class="navbar-text text-danger" style="margin-right:10px">
                       ${erro }
               </span>
                <form class="form-inline my-lg-0" action="login" method="post">
                    <div class="row">
                        <div class="col">
                            <input
                                    class="form-control mr-sm-2"
                                    type="text"
                                    name="email"
                                    placeholder="E-mail">
                        </div>
                        <div class="col">
                            <input
                                    class="form-control mr-sm-2"
                                    type="password"
                                    name="password"
                                    placeholder="Senha">
                        </div>
                        <div class="col">
                            <button class="btn btn-outline-success my-2 my-sm-0"
                                    type="submit">Entrar
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>
            <c:if test="${not empty user }">
               <span class="navbar-text"> Bem vindo,
                   ${user.getName() }!
                   <a href="login" class="btn btn-outline-primary my-2 my-sm-0">Sair</a>
               </span>
            </c:if>
            <ul class="navbar-nav mx-1 mb-2 mb-lg-0">
                <li class="nav-item">
                    <button id="toggleTheme" class="btn btn-outline-light border-light text-light ms-auto">
                        <i id="themeIcon" class="fa-solid fa-moon"></i>
                    </button>
                </li>
            </ul>

        </div>
    </div>
</nav>
<script>
    const savedTheme = localStorage.getItem('theme');
    const body = document.body;
    const toggleButton = document.getElementById('toggleTheme');
    const themeIcon = document.getElementById('themeIcon');

    if (savedTheme === 'dark') {
        body.setAttribute('data-bs-theme', 'dark');
        themeIcon.classList.remove('fa-moon');
        themeIcon.classList.add('fa-sun');
    }

    toggleButton.addEventListener('click', () => {
        const isDarkMode = body.getAttribute('data-bs-theme') === 'dark';

        if (isDarkMode) {
            body.setAttribute('data-bs-theme', 'light');
            toggleButton.classList.remove('border-light', 'text-light');
            toggleButton.classList.add('border-dark', 'text-dark');

            themeIcon.classList.remove('fa-sun');
            themeIcon.classList.add('fa-moon');
            localStorage.setItem('theme', 'light');
        } else {
            body.setAttribute('data-bs-theme', 'dark');
            toggleButton.classList.remove('border-dark', 'text-dark');
            toggleButton.classList.add('border-light', 'text-light');
            themeIcon.classList.remove('fa-moon');
            themeIcon.classList.add('fa-sun');
            localStorage.setItem('theme', 'dark');
        }
    });
</script>