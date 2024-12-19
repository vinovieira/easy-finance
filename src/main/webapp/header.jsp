<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
          integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<nav class="navbar border-bottom border-body navbar-expand-lg">
    <div class="container-fluid">
        <c:if test="${empty user }">
            <a class="navbar-brand" href="#"><i class="fa-light fa-file-invoice-dollar"></i>EasyFinance</a>
        </c:if>
        <c:if test="${not empty user }">
        <a class="navbar-brand" href="dashboard?action=list"><i class="fa-light fa-file-invoice-dollar"></i> EasyFinance</a>
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
            <span class="navbar-text"> Bem vindo,
                   ${user.getName() }!
                   <a href="login" class="btn btn-outline-danger my-2 my-sm-0">Sair</a>
               </span>
            <ul class="navbar-nav mx-1 mb-2 mb-lg-0">
                <li class="nav-item">
                    <button id="toggleTheme" class="btn btn-outline-light border-light text-light ms-auto">
                        <i id="themeIcon" class="fa-regular fa-moon"></i>
                    </button>
                </li>
            </ul>
            </c:if>
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