package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;

import com.inspur.cams.sorg.base.data.SomSession;

/**
 * 社会组织届次dao接口
 * @author zhangjian
 * @date 2011-9-19
 */
public interface ISomSessionDao extends BaseCURD<SomSession> {

	/**
	 * 查询当前届次信息
	 * @return
	 */
	public DataSet getCurrentSession(String sorgId);
	
	/**
	 * 根据换届信息中的会议信息取届次信息，apply表insert方法中调用
	 * @param sorgId
	 * @return meetingId（负责人备案中的sessionId和meetingId一致）
	 */
	public String getLastSessionInfo(String sorgId);
	/**
	 * 查询该登记证号的社会组织下面是否存在填写的届次名称
	 * @param sorgCode 登记证号
	 * @param sessionName  届次名称
	 * @param sorgId  sorgId
	 */
	public DataSet findIfExist(String sorgCode, String sessionName,String sorgId);
	
	

}
