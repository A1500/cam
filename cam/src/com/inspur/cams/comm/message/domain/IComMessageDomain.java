package com.inspur.cams.comm.message.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.message.data.ComMessage;


/**
 * 首页消息框domain
 * @author 
 * @date 2014-02-14
 */
public interface IComMessageDomain {

	/**
	 * 查询 首页消息框
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 首页消息框
	 * @param pset
	 * @return
	 */
	public ComMessage get(String messageId);

	/**
	 * 增加 首页消息框
	 * @param comMessage
	 */
	@Trans
	public void insert(ComMessage comMessage);
	
	/**
	 * 修改 首页消息框
	 * @param comMessage
	 */
	@Trans
	public void update(ComMessage comMessage);
	
	/**
	 * 删除 首页消息框
	 * @param 
	 */
	@Trans
	public void delete(String messageId);

}