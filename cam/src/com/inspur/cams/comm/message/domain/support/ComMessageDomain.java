package com.inspur.cams.comm.message.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.message.dao.IComMessageDao;
import com.inspur.cams.comm.message.data.ComMessage;
import com.inspur.cams.comm.message.domain.IComMessageDomain;


/**
 * 首页消息框domain
 * @author 
 * @date 2014-02-14
 */
public class ComMessageDomain implements IComMessageDomain {

	@Reference
	private IComMessageDao comMessageDao;

	/**
	 * 查询 首页消息框
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return comMessageDao.query(pset);
	}

	/**
	 * 获取 首页消息框
	 * @param pset
	 * @return
	 */
	public ComMessage get(String messageId) {
		return comMessageDao.get(messageId);
	}

	/**
	 * 增加 首页消息框
	 * @param comMessage
	 */
	public void insert(ComMessage comMessage) {
		comMessageDao.insert(comMessage);
	}
	
	/**
	 * 修改 首页消息框
	 * @param comMessage
	 */
	public void update(ComMessage comMessage) {
		comMessageDao.update(comMessage);
	}
	
	/**
	 * 删除 首页消息框
	 * @param 
	 */
	public void delete(String messageId) {
		comMessageDao.delete(messageId);
	}

}