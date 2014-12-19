package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomSession;

/**
 * 社会组织届次domain接口
 * 
 * @author zhangjian
 * @date 2011-9-21
 */
public interface ISomSessionDomain {
	
	/**
	 * 查询届次信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查询当前届次信息
	 * @return
	 */
	public DataSet getCurrentSession(String sorgId);

	/**
	 * 增加届次信息
	 * @param somSession
	 */
	@Trans
	public void insert(SomSession somSession);

	/**
	 * 更新届次信息
	 * @param somSession
	 */
	@Trans
	public void update(SomSession somSession);
	/**
	 * 查询该登记证号的社会组织下面是否存在填写的届次名称
	 * @param sorgCode 登记证号
	 * @param sessionName  届次名称
	 * @param sorgId  sorgId
	 */
	public DataSet findIfExist(String sorgCode, String sessionName ,String sorgId);
	
}
