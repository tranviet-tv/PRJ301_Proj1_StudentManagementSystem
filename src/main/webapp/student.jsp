<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Student Management - PRJ301 SMS</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>
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
                    fontFamily: { "display": ["Inter", "sans-serif"] }
                }
            }
        }
    </script>
    <style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 font-display">
<div class="flex h-screen overflow-hidden">
    
    <!-- Sidebar -->
    <aside class="w-64 bg-primary text-white flex flex-col shrink-0">
        <div class="p-6 flex items-center gap-3 border-b border-white/10">
            <div class="bg-white/20 p-2 rounded-lg">
                <span class="material-symbols-outlined text-white">school</span>
            </div>
            <div>
                <h1 class="text-sm font-bold leading-none"><a href="index.jsp">PRJ301 SMS</a></h1>
                <p class="text-[10px] text-white/60 uppercase tracking-widest mt-1">Management Portal</p>
            </div>
        </div>
        <nav class="flex-1 px-4 py-6 space-y-2">
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg text-white/70 hover:bg-white/5 hover:text-white transition-colors" href="department">
                <span class="material-symbols-outlined">domain</span>
                <span class="text-sm font-medium">Departments</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg bg-white/10 text-white transition-colors" href="student">
                <span class="material-symbols-outlined">group</span>
                <span class="text-sm font-medium">Students</span>
            </a>
        </nav>
        <div class="p-4 border-t border-white/10">
            <a href="logout" class="flex items-center gap-3 px-4 py-3 rounded-lg text-white/70 hover:bg-red-500/20 hover:text-red-400 transition-colors">
                <span class="material-symbols-outlined">logout</span>
                <span class="text-sm font-medium">Logout</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 flex flex-col overflow-hidden">
        <header class="h-16 bg-white dark:bg-background-dark border-b border-slate-200 dark:border-slate-800 flex items-center justify-between px-8 shrink-0">
            <div class="flex items-center gap-2">
                <span class="text-slate-400">Pages</span>
                <span class="text-slate-400">/</span>
                <span class="font-medium text-primary">Student Management</span>
            </div>
            <div class="flex items-center gap-6">
                <div class="flex items-center gap-3">
                    <div class="text-right">
                        <p class="text-sm font-bold text-slate-900 dark:text-slate-100">${sessionScope.account.username}</p>
                        <p class="text-[10px] text-slate-500 font-medium uppercase tracking-tight">
                            ${sessionScope.account.role == 1 ? 'Manager' : (sessionScope.account.role == 2 ? 'Staff' : 'Guest')}
                        </p>
                    </div>
                    <img alt="User Profile" class="h-10 w-10 rounded-full border-2 border-primary/10" src="https://ui-avatars.com/api/?name=${sessionScope.account.username}&background=random"/>
                </div>
                <a href="logout" class="bg-slate-100 hover:bg-slate-200 text-slate-700 px-4 py-2 rounded-lg text-sm font-bold transition-all flex items-center gap-2">
                    <span class="material-symbols-outlined text-sm">logout</span> Logout
                </a>
            </div>
        </header>

        <div class="flex-1 overflow-y-auto p-8 space-y-8 bg-slate-50/50 dark:bg-background-dark/50">
            
            <div class="flex justify-between items-end">
                <div>
                    <h2 class="text-3xl font-black text-primary tracking-tight">Student Management</h2>
                    <p class="text-slate-500 mt-1">Manage institutional records, academic performance, and departmental allocations.</p>
                </div>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg font-semibold">
                    ${errorMessage}
                </div>
            </c:if>

            <!-- Only Staff (Role 2) can see the Add/Edit Form -->
            <c:if test="${sessionScope.account.role == 2}">
                <section class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                    <div class="px-6 py-4 border-b border-slate-200 dark:border-slate-800 bg-slate-50/50 flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary text-lg">edit_note</span>
                        <h3 class="font-bold text-primary">${not empty studentEdit ? 'Update Student Record' : 'Add New Student Record'}</h3>
                    </div>
                    <div class="p-6">
                        <form action="student" method="post" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 items-end">
                            <input type="hidden" name="action" value="${not empty studentEdit ? 'update' : 'add'}">
                            <input type="hidden" name="id" value="${studentEdit.id}">

                            <div class="space-y-2">
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Student ID</label>
                                <input type="text" name="studentid" value="${studentEdit.getId()}" required class="w-full bg-slate-50 border-slate-200 rounded-lg focus:ring-primary focus:border-primary text-sm h-11" placeholder="e.g. STU-2023-001" ${not empty studentEdit ? 'readonly' : ''}/>
                            </div>
                            <div class="space-y-2">
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Full Name</label>
                                <input type="text" name="name" value="${studentEdit.getName()}" required class="w-full bg-slate-50 border-slate-200 rounded-lg focus:ring-primary focus:border-primary text-sm h-11" placeholder="Student Name"/>
                            </div>
                            <div class="space-y-2">
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">GPA (0.0 - 10.0)</label>
                                <input type="number" step="0.05" name="gpa" value="${studentEdit.getGpa()}" required class="w-full bg-slate-50 border-slate-200 rounded-lg focus:ring-primary focus:border-primary text-sm h-11" placeholder="0.00"/>
                            </div>
                            <div class="space-y-2">
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Department</label>
                                <select name="departmentId" required class="w-full bg-slate-50 border-slate-200 rounded-lg focus:ring-primary focus:border-primary text-sm h-11">
                                    <option value="">Select Department</option>
                                    <c:forEach items="${listDepartments}" var="dept">
                                        <option value="${dept.id}" ${studentEdit.departmentId.id == dept.id ? 'selected' : ''}>
                                            ${dept.departmentname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="lg:col-span-4 flex justify-end gap-3 pt-2">
                                <c:choose>
                                    <c:when test="${not empty studentEdit}">
                                        <a href="student" class="px-6 py-2.5 bg-slate-100 text-slate-700 font-bold rounded-lg hover:bg-slate-200 transition-colors text-sm border border-slate-200">Cancel</a>
                                        <button type="submit" class="px-8 py-2.5 bg-blue-600 text-white font-bold rounded-lg hover:bg-blue-700 shadow-md transition-all text-sm flex items-center gap-2">
                                            <span class="material-symbols-outlined text-sm">save</span> Update Student
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="reset" class="px-6 py-2.5 bg-slate-100 text-slate-700 font-bold rounded-lg hover:bg-slate-200 transition-colors text-sm border border-slate-200">Clear</button>
                                        <button type="submit" class="px-8 py-2.5 bg-primary text-white font-bold rounded-lg hover:bg-primary/90 shadow-md transition-all text-sm flex items-center gap-2">
                                            <span class="material-symbols-outlined text-sm">person_add</span> Add Student
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </form>
                    </div>
                </section>
            </c:if>

            <!-- Data Table -->
            <section class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden flex flex-col">
                <div class="px-6 py-5 border-b border-slate-200 dark:border-slate-800 flex justify-between items-center">
                    <h3 class="font-bold text-lg text-primary">Student Directory</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800 text-[11px] uppercase tracking-wider font-bold text-slate-500">
                                <th class="px-6 py-4">ID / Student ID</th>
                                <th class="px-6 py-4">Name</th>
                                <th class="px-6 py-4">GPA</th>
                                <th class="px-6 py-4">Department</th>
                                <th class="px-6 py-4 text-center">Creator</th>
                                <th class="px-6 py-4">Timestamps</th>
                                <c:if test="${sessionScope.account.role == 2}">
                                    <th class="px-6 py-4 text-right">Actions</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                            <c:forEach items="${listStudents}" var="s">
                                <tr class="hover:bg-slate-50/80 transition-colors group">
                                    <td class="px-6 py-4">
                                        <div class="text-sm font-bold text-primary">${s.getStudentid()}</div>
                                        <div class="text-xs text-slate-400">ID: ${s.getId()}</div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="h-8 w-8 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center font-bold text-xs uppercase">${s.getName().substring(0,2)}</div>
                                            <span class="text-sm font-semibold text-slate-700">${s.getName()}</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold ${s.getGpa() >= 5 ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}">
                                            ${s.getGpa()}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-600">${s.getDepartmentName()}</td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="text-[11px] font-bold text-slate-500 bg-slate-100 px-2 py-1 rounded">${s.getCreatedBy()}</span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="text-[10px] leading-tight">
                                            <p class="text-slate-400">C: <span class="text-slate-600 font-medium">${s.getCreatedAt()}</span></p>
                                            <p class="text-slate-400">U: <span class="text-slate-600 font-medium">${s.getUpdatedAt()}</span></p>
                                        </div>
                                    </td>
                                    <c:if test="${sessionScope.account.role == 2}">
                                        <td class="px-6 py-4 text-right">
                                            <c:if test="${sessionScope.account.username == s.createdBy}">
                                                <div class="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                                    <a href="student?action=edit&id=${s.id}" class="p-1.5 text-blue-600 hover:bg-blue-50 rounded transition-colors" title="Edit"><span class="material-symbols-outlined text-lg">edit</span></a>
                                                    <a href="student?action=delete&id=${s.id}" onclick="return confirm('Delete this student?');" class="p-1.5 text-red-600 hover:bg-red-50 rounded transition-colors" title="Delete"><span class="material-symbols-outlined text-lg">delete</span></a>
                                                </div>
                                            </c:if>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <c:if test="${sessionScope.account.role == 2 && totalPages > 1}">
                    <div class="px-6 py-4 border-t border-slate-200 dark:border-slate-800 flex items-center justify-between bg-slate-50/50">
                        <p class="text-xs text-slate-500 font-medium">Page Navigation</p>
                        <div class="flex items-center gap-1">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="student?page=${i}" class="w-8 h-8 rounded-lg text-xs font-bold flex items-center justify-center transition-colors ${currentPage == i ? 'bg-primary text-white' : 'text-slate-600 hover:bg-white border border-transparent hover:border-slate-200'}">
                                    ${i}
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </section>
        </div>

        <footer class="h-10 border-t border-slate-200 px-8 flex items-center justify-between text-[10px] text-slate-400 uppercase tracking-widest shrink-0">
            <span>© 2026 Academic System Inc.</span>
        </footer>
    </main>
</div>
</body>
</html>