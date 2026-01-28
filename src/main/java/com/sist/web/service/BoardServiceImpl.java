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

	// ===== 게시글 상세 =====
	@Override
	public Map<String, Object> boardDetailAllData(int no) {
		mapper.boardHitIncrement(no);
		
		Map<String, Object> map = new HashMap<>();
		map.put("vo", mapper.boardDetailData(no));
		map.put("prev", mapper.boardPrevData(no));
		map.put("next", mapper.boardNextData(no));
		map.put("replyList", mapper.replyListData(no));
		
		return map;
	}

	@Override
	public BoardVO boardDetailData(int no) {
		return mapper.boardDetailData(no);
	}

	// ===== 게시글 작성/수정/삭제 =====
	@Override
	public void boardInsert(BoardVO vo) {
		mapper.boardInsert(vo);
	}

	@Override
	@Transactional
	public String boardUpdate(BoardVO vo, String sessionId) {
		BoardVO dbVO = mapper.boardDetailData(vo.getId());
		if (dbVO != null && dbVO.getMem_id().equals(sessionId)) {
			mapper.boardUpdate(vo);
			return "yes";
		}
		return "no";
	}

	@Override
	@Transactional
	public String boardDelete(int no, String sessionId) {
		BoardVO vo = mapper.boardDetailData(no);
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
			// 일반 댓글
			vo.setGroup_id(newId);
			vo.setGroup_step(0);
			vo.setGroup_tab(0);
		} else {
			// 답글
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