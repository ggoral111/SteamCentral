import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.steamcentral.hibernate.dao.UserDAO;

public class HibernateTest {
	
	@Autowired
    private UserDAO userDao;
	
	@Ignore
	@BeforeClass
	public static void setUpClass() {
		
	}
	
	@Ignore
	@AfterClass
	public static void tearDownClass() {
		System.out.println("Hibernate testing ended!");
	}
	
	@Ignore
	@Test
	public void addUserToDatabase() {		
		/*User user = new User("76566666666", "ToNowkaNiesmigana", "TO PRAWDA!", "dfgdregdf");
		userDao.addUser(user);*/
		
		/*Session session = sessionFactory.getCurrentSession();
		Transaction tx = null;
		
		try {
			tx= session.beginTransaction();
			User user = new User("76561198055555", "AleJaja", "TO PRAWDA!", "dfgdregdf");
	        session.saveOrUpdate(user);
	        tx.commit();		
		} catch(HibernateException ex) {
			if (tx != null) {
				tx.rollback();
			}
			
			ex.printStackTrace();		
		} finally {
	    	session.close(); 
	    }*/
	}

}
