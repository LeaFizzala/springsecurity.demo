package springsecurity.demo.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class DemoConfigSecurite {
	
	// on ajoute une référence à la datasource
	
	@Autowired
	private DataSource securityDataSource;
	
//	@Bean // plus besoin de cette méthode car on va chercher directement dans la BDD
//	public InMemoryUserDetailsManager userDetailsService() {
//	        
//	        UserDetails user = User.withUsername("employe").password("{noop}test123").roles("EMPLOYE").build();
//	        UserDetails admin = User.withUsername("admin").password("{noop}test123").roles("ADMIN", "EMPLOYE").build();
//	        UserDetails manager = User.withUsername("manager").password("{noop}test123").roles("MANAGER","EMPLOYE").build();
//	        return new InMemoryUserDetailsManager(user, admin, manager);
//	        
//	}
	
	 @Autowired
	 protected void configure(AuthenticationManagerBuilder auth) throws Exception {
	        
	        // utiliser l'authentification JDBC
	        auth.jdbcAuthentication().dataSource(securityDataSource);
	        
	 }
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	        
	    http.authorizeHttpRequests(authorize -> authorize
	    .antMatchers("/resources/**")
	    .permitAll()  
	    .antMatchers("/").hasRole("EMPLOYE")
	    .antMatchers("/admins").hasRole("ADMIN")
	    .antMatchers("/managers").hasRole("MANAGER")
	    .anyRequest()
	    .authenticated()
	        )
	        .formLogin(form -> form.loginPage("/login")
	        .loginProcessingUrl("/authenticateLogin")
	        .permitAll()
	)
	        .logout().permitAll()
	        .and()
	        .exceptionHandling().accessDeniedPage("/accesRefuse");
	 
	    return http.build();
	        
	}

}
