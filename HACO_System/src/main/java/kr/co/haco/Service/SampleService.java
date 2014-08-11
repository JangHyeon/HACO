package kr.co.haco.Service;

import java.util.*;

import org.springframework.security.access.prepost.PreAuthorize;


public interface SampleService {

	/*
	 * 게시판 목록
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public ArrayList<Object> getArticleList(String boardCd, String searchWord,
			int start, int end);

	/*
	 * 특정 게시판의 총 게시물 갯수 구하기
	 */
	public int getTotalRecord(String boardCd, String searchWord);

	/*
	 * 새로운 게시글 추가
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public int insert(Object article);

	/*
	 * 첨부파일
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Object getAttachFile(int attachFileNo);

	/*
	 * 새로운 첨부파일 추가
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void insertAttachFile(Object attachFile);

	/*
	 * 게시글 수정
	 */
	@PreAuthorize("#article.email == principal.username or hasRole('ROLE_ADMIN')")
	public void update(Object article);

	/*
	 * 게시글 삭제 기존 delete(int)를 수정
	 */
	@PreAuthorize("#article.email == principal.username or hasRole('ROLE_ADMIN')")
	public void delete(Object article);

	/*
	 * 조회수 증가
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void increaseHit(int articleNo);

	/*
	 * 게시글 상세보기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Object getArticle(int articleNo);

	/*
	 * 다음글 보기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Object getNextArticle(int articleNo, String boardCd,
			String searchWord);

	/*
	 * 이전글 보기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Object getPrevArticle(int articleNo, String boardCd,
			String searchWord);

	/*
	 * 게시글의 첨부파일 리스트
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public ArrayList<Object> getAttachFileList(int articleNo);

	/*
	 * 첨부파일 삭제
	 */
	@PreAuthorize("#email == principal.username or hasRole('ROLE_ADMIN')")
	public void deleteFile(int attachFileNo);

	/*
	 * 게시판이름 구하기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public String getBoardNm(String boardCd);

	/*
	 * 게시판종류 리스트 구하기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public ArrayList<Object> getBoardList();

	/*
	 * 덧글쓰기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void insertComment(Object comment);

	/*
	 * 덧글수정
	 */
	@PreAuthorize("#comment.email == principal.username or hasRole('ROLE_ADMIN')")
	public void updateComment(Object comment);

	/*
	 * 덧글삭제
	 */
	@PreAuthorize("#comment.email == principal.username or hasRole('ROLE_ADMIN')")
	public void deleteComment(int commentNo);

	/*
	 * 덧글가져오기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Object getComment(int commentNo);

	/*
	 * 게시글의 덧글리스트 구하기
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public ArrayList<Object> getCommentList(int articleNo);

	public int getListNo();

	public int getPrevLink();

	public int getFirstPage();

	public int getLastPage();

	public int getNextLink();

	public int[] getPageLinks();

	public void setPagingHelper(Object pagingHelper);

}