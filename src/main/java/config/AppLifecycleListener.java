package config;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppLifecycleListener implements ServletContextListener {

    // Khai bao public static de cac file DAO sau nay co the goi ra dung chung
    public static EntityManagerFactory emf;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Ham nay tu dong chay NGAY KHI Tomcat vua deploy xong project cua ban
        System.out.println("🚀 [System] Dang khoi dong Web App va kich hoat JPA...");
        
        try {
            // Tu dong kich hoat JPA, doc file XML va sinh bang duoi Database
            emf = Persistence.createEntityManagerFactory("PRJ301Proj1_PU");
            System.out.println("✅ [System] JPA da san sang! Database da duoc cap nhat.");
        } catch (Exception e) {
            System.err.println("❌ [System] Loi khoi tao JPA: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Ham nay tu dong chay khi ban Tat Tomcat hoac Undeploy project
        System.out.println("🛑 [System] Dang tat Web App, don dep ket noi Database...");
        
        if (emf != null && emf.isOpen()) {
            emf.close(); // Dong ket noi de tranh tran bo nho (Memory Leak)
            System.out.println("✅ [System] Da dong EntityManagerFactory an toan.");
        }
    }
}