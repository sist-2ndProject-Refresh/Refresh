package com.sist.web.security;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import jakarta.servlet.http.HttpSession;

public class SessionUtils {
	private static final Map<String, HttpSession> STORE=new ConcurrentHashMap<>();
	
	public static void add(HttpSession session) // 세션 추가
	{
		STORE.put(session.getId(), session);
	}
	
	public static void remove(HttpSession session) // 세션 제거
	{
		STORE.remove(session);
	}
	
	public static void invalidate(String sessionId)
	{
		HttpSession session=STORE.get(sessionId);
		if(session!=null)
		{
			session.invalidate();
			STORE.remove(sessionId);
		}
	}
}
