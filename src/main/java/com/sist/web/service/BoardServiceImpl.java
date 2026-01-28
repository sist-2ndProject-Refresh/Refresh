package com.sist.web.service;

import java.util.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.sist.web.mapper.BoardMapper;
import com.sist.web.vo.*;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper;

	// ===== 게시글 목록 =====
	@Override
	public List<BoardVO> BoardListData(int start, String fd) {
		return mapper.BoardListData(start, fd);
	}

	@Override
	public int BoardTotalPage(String fd) {
		return mapper.BoardTotalPage(fd);
	}

	// ===== 게시글 상세 (좋아요 여부 포함) =====
	@Override
	@Transactional
	public Map<String, Object> boardDetailAllData(int no, String username) {
		// 1. 조회수 증가
		mapper.boardHitIncrement(no);
		
		Map<String, Object> map = new HashMap<>();
		// 2. 게시글 상세 정보 (좋아요 개수 + 로그인 유저의 좋아요 여부 포함)
		map.put("vo", mapper.boardDetailData(no, username));
		map.put("prev", mapper.boardPrevData(no));
		map.put("next", mapper.boardNextData(no));
		map.put("replyList", mapper.replyListData(no));
		
		return map;
	}

	@Override
	public BoardVO boardDetailData(int no, String username) {
		return mapper.boardDetailData(no, username);
	}

	// [추가] ===== 좋아요 토글 기능 =====
	@Override
	@Transactional
	public BoardVO boardLikeToggle(int no, String username) {
		// 1. 이미 좋아요를 눌렀는지 확인
		int count = mapper.boardLikeCheck(no, username);
		
		// 2. 토글 처리 (0이면 추가, 1이면 삭제)
		if (count == 0) {
			mapper.boardLikeInsert(no, username);
		} else {
			mapper.boardLikeDelete(no, username);
		}
		
		// 3. 최신 좋아요 정보(개수, 상태)가 담긴 VO를 다시 반환
		return mapper.boardDetailData(no, username);
	}

	// ===== 게시글 작성/수정/삭제 =====
	@Override
	public void boardInsert(BoardVO vo) {
		mapper.boardInsert(vo);
	}

	@Override
	@Transactional
	public String boardUpdate(BoardVO vo, String sessionId) {
		// 수정 시에도 username이 필요하므로 빈 문자열 혹은 실제 ID 전달
		BoardVO dbVO = mapper.boardDetailData(vo.getId(), sessionId);
		if (dbVO != null && dbVO.getMem_id().equals(sessionId)) {
			mapper.boardUpdate(vo);
			return "yes";
		}
		return "no";
	}

	@Override
	@Transactional
	public String boardDelete(int no, String sessionId) {
		BoardVO vo = mapper.boardDetailData(no, sessionId);
		if (vo != null && vo.getMem_id().equals(sessionId)) {
			mapper.boardDelete(no);
			return "yes";
		}
		return "no";
	}

	// ===== 회원 정보 =====
	@Override
	public String getMemberAddr(String username) {
		return mapper.getMemberAddr(username);
	}

	// ===== 댓글 목록 =====
	@Override
	public List<BoardReplyVO> replyListData(int bno) {
		return mapper.replyListData(bno);
	}

	// ===== 댓글 작성 =====
	@Override
	@Transactional
	public void replyInsert(BoardReplyVO vo, int pId) {
		int newId = mapper.replyNewId();
		vo.setId(newId);
		
		if (pId == 0) {
			vo.setGroup_id(newId);
			vo.setGroup_step(0);
			vo.setGroup_tab(0);
		} else {
			BoardReplyVO pVO = mapper.replyParentInfo(pId);
			mapper.replyStepIncrement(pVO);
			vo.setGroup_id(pVO.getGroup_id());
			vo.setGroup_step(pVO.getGroup_step() + 1);
			vo.setGroup_tab(pVO.getGroup_tab() + 1);
		}
		
		mapper.replyInsert(vo);
	}

	// ===== 댓글 수정 =====
	@Override
	public String replyUpdate(BoardReplyVO vo, String sessionId) {
		mapper.replyUpdate(vo);
		return "yes";
	}

	// ===== 댓글 삭제 =====
	@Override
	public void replyDelete(int id) {
		mapper.replyDelete(id);
	}
}