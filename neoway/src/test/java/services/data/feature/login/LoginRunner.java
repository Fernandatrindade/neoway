package services.data.feature.login;

import com.intuit.karate.junit5.Karate;

class LoginRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("login").relativeTo(getClass());
    }    

}
