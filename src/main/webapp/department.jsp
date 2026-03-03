<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Department Management Page</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#1d283a",
                        "background-light": "#f6f7f7",
                        "background-dark": "#16181c",
                    },
                    fontFamily: {
                        "display": ["Inter", "sans-serif"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .active-nav {
            background-color: rgba(29, 40, 58, 0.1);
            border-left: 4px solid #1d283a;
        }
    </style>
</head>
<body class="font-display bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
<div class="flex h-screen overflow-hidden">
    
    <!-- Sidebar Navigation -->
    <aside class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-slate-800 flex flex-col">
        <div class="p-6 flex items-center gap-3 border-b border-slate-100 dark:border-slate-800">
            <div class="size-10 bg-primary rounded-lg flex items-center justify-center text-white">
                <span class="material-symbols-outlined">corporate_fare</span>
            </div>
            <h1 class="font-bold text-lg tracking-tight text-primary dark:text-slate-100 leading-tight">AdminPanel</h1>
        </div>
        <nav class="flex-1 px-4 py-6 space-y-2">
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg active-nav text-primary font-semibold" href="department">
                <span class="material-symbols-outlined">grid_view</span>
                <span>Departments</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="student">
                <span class="material-symbols-outlined">group</span>
                <span>Students</span>
            </a>
        </nav>
        <div class="p-4 border-t border-slate-100 dark:border-slate-800">
            <div class="flex items-center gap-3 p-2 mb-4">
                <img alt="User profile" class="size-10 rounded-full border-2 border-slate-200" src="https://ui-avatars.com/api/?name=${not empty sessionScope.account.username ? sessionScope.account.username : 'User'}&background=random"/>
                <div class="overflow-hidden">
                    <p class="text-sm font-bold truncate">${not empty sessionScope.account.username ? sessionScope.account.username : 'Guest'}</p>
                    <p class="text-xs text-slate-500 truncate">
                        ${sessionScope.account.role == 1 ? 'Manager' : (sessionScope.account.role == 2 ? 'Staff' : 'User')}
                    </p>
                </div>
            </div>
            <a href="logout" class="w-full flex items-center justify-center gap-2 px-4 py-2 text-sm font-medium text-red-600 hover:bg-red-50 rounded-lg transition-colors">
                <span class="material-symbols-outlined text-sm">logout</span>
                Logout
            </a>
        </div>
    </aside>

    <!-- Main Content Area -->
    <main class="flex-1 flex flex-col overflow-hidden">
        <!-- Header -->
        <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 flex items-center justify-between px-8 z-10">
            <div class="flex items-center gap-2">
                <span class="text-slate-400 material-symbols-outlined">folder_open</span>
                <h2 class="text-sm font-medium text-slate-500 uppercase tracking-wider">Management / <span class="text-slate-900 dark:text-white">Departments</span></h2>
            </div>
            <div class="flex items-center gap-6">
                <a href="logout" class="bg-primary text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center gap-2 hover:opacity-90 transition-opacity">
                    <span class="material-symbols-outlined text-sm">logout</span>
                    Logout
                </a>
            </div>
        </header>

        <!-- Content Body -->
        <div class="flex-1 overflow-y-auto p-8">
            <div class="max-w-6xl mx-auto space-y-8">
                
                <!-- Title Section -->
                <div class="flex items-end justify-between">
                    <div>
                        <h3 class="text-3xl font-black text-slate-900 dark:text-white tracking-tight">Department Management</h3>
                        <p class="text-slate-500 mt-1">Configure and manage your organization's departmental structure.</p>
                    </div>
                </div>

                <!-- Add/Edit Department Card -->
                <section class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                    <div class="p-6 border-b border-slate-100 dark:border-slate-800 bg-slate-50/50">
                        <h4 class="font-bold text-slate-900 dark:text-white flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">${not empty requestScope.departmentedit ? 'edit' : 'add_circle'}</span>
                            ${not empty requestScope.departmentedit ? 'Edit Department' : 'Add New Department'}
                        </h4>
                    </div>
                    <div class="p-6">
                        <form action="department" method="POST" class="flex flex-col gap-6">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="w-full">
                                    <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1" for="id">Department ID</label>
                                    <input type="text" name="id" id="id" 
                                           value="${requestScope.departmentedit != null ? departmentedit.getId() : ''}" 
                                           ${requestScope.departmentedit != null ? 'readonly' : ''}
                                           class="w-full px-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 ${requestScope.departmentedit != null ? 'bg-slate-100 text-slate-500 cursor-not-allowed' : 'bg-slate-50 dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary'} text-sm" 
                                           placeholder="e.g. DEP-001" required/>
                                </div>
                                
                                <div class="w-full">
                                    <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1" for="departmentname">Department Name</label>
                                    <input type="text" name="departmentname" id="departmentname" 
                                           value="${requestScope.departmentedit != null ? departmentedit.getDepartmentname() : ''}" 
                                           class="w-full px-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary text-sm" 
                                           placeholder="e.g. Computer Science" required/>
                                </div>
                            </div>
                            
                            <div class="flex items-center gap-4 pt-2">
                                <c:choose>
                                    <c:when test="${not empty requestScope.departmentedit}">
                                        <button type="submit" name="action" value="update" class="h-[46px] px-8 bg-blue-600 text-white font-bold rounded-lg hover:bg-blue-700 transition-colors flex items-center justify-center gap-2">
                                            <span class="material-symbols-outlined text-sm">save</span>
                                            Update Department
                                        </button>
                                        <a href="department" class="h-[46px] px-8 bg-slate-200 text-slate-700 font-bold rounded-lg hover:bg-slate-300 transition-colors flex items-center justify-center gap-2">
                                            Cancel
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" name="action" value="add" class="h-[46px] px-8 bg-primary text-white font-bold rounded-lg hover:bg-slate-800 transition-colors flex items-center justify-center gap-2">
                                            <span class="material-symbols-outlined text-sm">add</span>
                                            Add Department
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </form>
                    </div>
                </section>

                <!-- Department List Table -->
                <section class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                    <div class="p-6 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between bg-slate-50/50">
                        <h4 class="font-bold text-slate-900 dark:text-white">Department List</h4>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                    <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-widest">ID</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-widest">Department Name</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-widest text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                                <c:forEach var="dep" items="${requestScope.listDepartments}">
                                    <tr class="hover:bg-slate-50/80 dark:hover:bg-slate-800/30 transition-colors">
                                        <td class="px-6 py-4 text-sm font-medium text-slate-500">${dep.getId()}</td>
                                        <td class="px-6 py-4 text-sm font-semibold text-slate-900 dark:text-white">${dep.getDepartmentname()}</td>
                                        <td class="px-6 py-4 text-right">
                                            <div class="flex justify-end gap-2">
                                                <a href="department?action=edit&id=${dep.getId()}" class="p-2 text-slate-400 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-all" title="Edit">
                                                    <span class="material-symbols-outlined">edit</span>
                                                </a>
                                                <a href="department?action=delete&id=${dep.getId()}" onclick="return confirm('Are you sure you want to delete this department?');" class="p-2 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all" title="Delete">
                                                    <span class="material-symbols-outlined">delete</span>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </section>

            </div>
        </div>

        <!-- Footer -->
        <footer class="py-4 px-8 border-t border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 text-center">
            <p class="text-xs text-slate-400 font-medium tracking-wide">© 2026 University Management System - Department Portal</p>
        </footer>
    </main>
</div>
</body>
</html>