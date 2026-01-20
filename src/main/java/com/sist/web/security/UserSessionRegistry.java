package com.sist.web.security;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

@Component
public class UserSessionRegistry {
	private final Set<Integer> users=ConcurrentHashMap.newKeySet();
	public void add(int userno)
	{
		users.add(userno);
	}
	
	public void remove(int userno)
	{
		users.remove(userno);
	}
	
	public Set<Integer> getUsers()
	{
		return users;
	}
}