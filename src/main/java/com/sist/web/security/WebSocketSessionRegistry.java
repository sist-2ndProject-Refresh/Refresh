package com.sist.web.security;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

@Component
public class WebSocketSessionRegistry {
	// 접속중인 사용자들의 웹소켓 세션을 저장하는 곳
	private final Map<String, Set<String>> map=new ConcurrentHashMap<>();
	// Map => 유저별로 관리, Set => 중복 세션 방지, ConcurrentHashMap => 멀티쓰레드 안전
	
	public void register(String username, String sessionId) // 접속 시 저장
	{
		map.computeIfAbsent(username, k->ConcurrentHashMap.newKeySet()).add(sessionId);
		// no 에 해당하는 Set 이 없으면 생성하고, 그 Set 에 sessionId 추가
	}
	
	public void unregister(String username, String sessionId) // 접속 해제
	{
		Set<String> set=map.get(username); // 해당 유저 세션 호출
		if(set!=null)
		{
			set.remove(sessionId); // 세션 제거
			if(set.isEmpty())
			{
				map.remove(username); // 세션 없으면 유저 삭제
			}
		}
	}
	
	public Set<String> getSession(int userno) // 특정 유저 세션 조회
	{
		return map.getOrDefault(userno, Set.of()); // 있으면 세션 Set 반환 없으면 빈 Set 반환
	}
}
