package com.sparkmind.service;

import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sparkmind.model.Person;
import com.sparkmind.model.Role;
import com.sparkmind.model.User;

@Service
public class UserServiceImpl implements UserService {
    
	protected static Logger logger = Logger.getLogger("service");
	
	@PersistenceContext
    EntityManager em;
    
	@Override
	public User findByUsername(String email) {
		
		Query query = em.createQuery("SELECT DISTINCT user from User user join fetch user.role WHERE user.email=:email");
		query.setParameter("email", email);
		return (User) query.getSingleResult();
	}	
	@Override
	public List<User> findUsers(String query){
		String sqlName = ("%" + query + "%").toLowerCase();
		Query q = em.createQuery("FROM User u WHERE u.email like :email").setParameter("email", sqlName);
		return q.getResultList();
	}

	@Override
	public List<User> getAllUsers() {
		Query q = em.createQuery("FROM User");
		return q.getResultList();
	}

	@Override
	public User getUserById(Long id) {
		User user = (User)em.createQuery("SELECT DISTINCT user from User user join fetch user.role WHERE user.id=:id")
				.setParameter("id", id)
				.getSingleResult();
		return user;
	}
	
	@Override
	public User findByGuid(String guid) {
		User user = (User)em.createQuery("FROM User u where u.guid=:guid")
				.setParameter("guid", guid)
				.getSingleResult();
		return user;
	}
	
	@Override
	@Transactional
	public void addUser(User user){
		if (user.getId()==null){
			em.persist(user);
		}
		else{
			em.merge(user);
		}
	}
	
	@Override
	@Transactional
	public User updateUser(User user){			
			User existingUser = em.find(User.class, user.getId());
			if (existingUser ==null){
				return null;
			}
			existingUser.setEmail(user.getEmail());
			existingUser.setFirstName(user.getFirstName());
			existingUser.setLastName(user.getLastName());
			existingUser.setPassword(user.getPassword());
			existingUser.setUserConfirmation(user.getUserConfirmation());
			existingUser.getRole().setRole(user.getRole().getRole());
			
			 Role role = user.getRole();
			 role.setUser(user);
			 role.setRole(user.getRole().getRole());
			 
			 em.merge(existingUser.getRole());
			return em.merge(existingUser);
	}

	@Override
	@Transactional
	public void deleteUser(Long userId) {
		  User user = em.find(User.class, userId);
	        if (user!=null) {	        	
	            em.remove(user);
	        }		
	}
}
