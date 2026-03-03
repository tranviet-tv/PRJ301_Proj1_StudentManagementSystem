<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>User Registration - PRJ301 SMS</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#1366ec",
                        "background-light": "#f6f7f8",
                        "background-dark": "#101722",
                    },
                    fontFamily: { "display": ["Inter", "sans-serif"] }
                }
            }
        }
    </script>
</head>
<body class="bg-background-light dark:bg-background-dark font-display antialiased min-h-screen flex flex-col">
    <header class="flex items-center justify-between whitespace-nowrap border-b border-solid border-slate-200 dark:border-slate-800 px-10 py-3 bg-white dark:bg-[#151c2a]">
        <div class="flex items-center gap-4 text-slate-900 dark:text-slate-100">
            <span class="material-symbols-outlined text-3xl font-bold text-primary">school</span>
            <h2 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]"><a href="index.jsp">PRJ301 SMS</a></h2>
        </div>
    </header>

    <main class="flex-1 flex justify-center items-center p-4 sm:p-8">
        <div class="flex w-full max-w-[1000px] overflow-hidden bg-white dark:bg-[#151c2a] rounded-xl shadow-lg border border-slate-200 dark:border-slate-800">
            <div class="flex-1 p-8 sm:p-12 flex flex-col justify-center">
                <div class="mb-8">
                    <h1 class="text-slate-900 dark:text-white tracking-tight text-[32px] font-bold leading-tight mb-2">Create your account</h1>
                    <p class="text-slate-500 dark:text-slate-400 text-base font-normal leading-normal">Register for the PRJ301 Student Management System.</p>
                </div>
                
                <c:if test="${requestScope.msg != null}">
                    <div class="mb-6 p-3 rounded-lg bg-blue-50 border border-blue-200 text-blue-700 text-sm font-medium">
                        ${requestScope.msg}
                    </div>
                </c:if>

                <form action="register" method="POST" class="space-y-5">
                    <label class="block">
                        <span class="text-slate-900 dark:text-slate-200 text-sm font-medium leading-normal mb-1 block">Full Name</span>
                        <div class="relative">
                            <input name="fullname" class="form-input block w-full rounded-lg border-slate-300 dark:border-slate-600 bg-slate-50 dark:bg-slate-900 text-slate-900 dark:text-white focus:border-primary focus:ring-primary sm:text-sm pl-10 py-3 placeholder:text-slate-400" placeholder="John Doe" type="text" required/>
                            <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-[20px]">person</span>
                        </div>
                    </label>

                    <label class="block">
                        <span class="text-slate-900 dark:text-slate-200 text-sm font-medium leading-normal mb-1 block">Username</span>
                        <div class="relative">
                            <input name="username" class="form-input block w-full rounded-lg border-slate-300 dark:border-slate-600 bg-slate-50 dark:bg-slate-900 text-slate-900 dark:text-white focus:border-primary focus:ring-primary sm:text-sm pl-10 py-3 placeholder:text-slate-400" placeholder="johndoe123" type="text" required/>
                            <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-[20px]">badge</span>
                        </div>
                    </label>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                        <label class="block">
                            <span class="text-slate-900 dark:text-slate-200 text-sm font-medium leading-normal mb-1 block">Password</span>
                            <div class="relative">
                                <input name="password" class="form-input block w-full rounded-lg border-slate-300 dark:border-slate-600 bg-slate-50 dark:bg-slate-900 text-slate-900 dark:text-white focus:border-primary focus:ring-primary sm:text-sm pl-10 py-3 placeholder:text-slate-400" placeholder="••••••••" type="password" required/>
                                <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-[20px]">lock</span>
                            </div>
                        </label>

                        <label class="block">
                            <span class="text-slate-900 dark:text-slate-200 text-sm font-medium leading-normal mb-1 block">Role</span>
                            <div class="relative">
                                <select name="role" class="form-select block w-full rounded-lg border-slate-300 dark:border-slate-600 bg-slate-50 dark:bg-slate-900 text-slate-900 dark:text-white focus:border-primary focus:ring-primary sm:text-sm pl-10 py-3" required>
                                    <option value="1">Manager</option>
                                    <option value="2">Staff</option>
                                    <option value="3" selected>Guest</option>
                                </select>
                                <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-[20px]">school</span>
                            </div>
                        </label>
                    </div>

                    <button type="submit" name="Register" class="w-full flex justify-center items-center rounded-lg bg-primary px-4 py-3 text-sm font-bold text-white shadow-sm hover:bg-blue-600 transition-colors mt-4">
                        Sign Up
                    </button>
                </form>

                <div class="mt-8 text-center">
                    <p class="text-sm text-slate-500 dark:text-slate-400 mb-2">Already have an account?</p>
                    <a href="login" class="inline-block w-full py-2.5 rounded-lg border border-primary text-primary font-bold hover:bg-primary/5 transition-colors text-center">
                        Log in
                    </a>
                </div>
            </div>

            <div class="hidden md:flex w-[400px] relative bg-slate-100 dark:bg-slate-800 flex-col justify-between p-8">
                <div class="absolute inset-0 z-0">
                    <img alt="University campus hallway" class="h-full w-full object-cover opacity-80 grayscale" src="https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=1000&auto=format&fit=crop"/>
                    <div class="absolute inset-0 bg-blue-900/70 mix-blend-multiply"></div>
                    <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
                </div>
                <div class="relative z-10 h-full flex flex-col justify-end text-white">
                    <div class="mb-6">
                        <span class="inline-flex items-center gap-1 rounded-full bg-white/20 backdrop-blur-sm px-3 py-1 text-xs font-medium text-white ring-1 ring-inset ring-white/30 mb-4">
                            <span class="material-symbols-outlined text-[16px]">school</span> Academic Portal
                        </span>
                        <h3 class="text-2xl font-bold mb-2">Empowering Education</h3>
                        <p class="text-slate-200 text-sm leading-relaxed">
                            Join the PRJ301 Student Management System to streamline your academic journey. Manage courses, grades, and schedules in one place.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <footer class="py-6 text-center text-sm text-slate-500 dark:text-slate-400 bg-transparent">
        © 2026 PRJ301 SMS. All rights reserved.
    </footer>
</body>
</html>