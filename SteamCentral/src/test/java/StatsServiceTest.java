import java.util.Set;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;

import com.steamcentral.core.model.SteamUserInfo;
import com.steamcentral.core.service.StatsService;

public class StatsServiceTest {
	
	private static StatsService ss;

	@BeforeClass
	public static void setUpClass() {
		ss = new StatsService();
	}
	
	@AfterClass
	public static void tearDownClass() {
		System.out.println("Testing ended!");
	}
	
	@Ignore
	@Test
	public void loadFriendListTest() {
		Set<SteamUserInfo> friendList = ss.getFriendListFullInfo("76561198078305233");		
		//assertNotNull(friendList);
		
		if(friendList != null) {
			System.out.println("friendList size(): " + friendList.size());
			System.out.println("===================================");
			
			for(SteamUserInfo sui : friendList) {
				System.out.println(sui.getSteamId());
				System.out.println(sui.getPersonaname());
				System.out.println(sui.getAvatarFullURL());
				System.out.println(sui.getPlaytimeTwoWeeks());
				System.out.println(sui.getPlaytimeForever());
				System.out.println("===================================");
			}
		}
	}
	
	@Ignore
	@Test
	public void getStrangerUserStatsTest() {
		Object[] statsObject = ss.getStrangerUserStats("76561198078305233");
		// assertNotNull(ss.getStrangerUserStats("76561198078305233"));
		
		if(statsObject != null) {			
			for(Object o : statsObject) {
				if(o instanceof String) {
					System.out.println((String) o);
				} else if(o instanceof SteamUserInfo) {
					SteamUserInfo sui = (SteamUserInfo) o;
					
					System.out.println(sui.getSteamId());
					System.out.println(sui.getPersonaname());
					System.out.println(sui.getAvatarFullURL());
					System.out.println(sui.getPlaytimeTwoWeeks());
					System.out.println(sui.getPlaytimeForever());
					System.out.println("===================================");
				}
			}
		} else {
			System.out.println("Object is null!");
		}
	}
	
	@Test
	public void getSkinsPricesTest() {
		ss.getSkinsPrices();
	}

}
