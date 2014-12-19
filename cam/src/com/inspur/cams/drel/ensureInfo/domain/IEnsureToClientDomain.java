package com.inspur.cams.drel.ensureInfo.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.ensureInfo.data.EnsureToClient;

/**
 * 核查业务反馈表domain
 * @author 
 * @date 2014-07-23
 */
public interface IEnsureToClientDomain {

	/**
	 * 查询 核查业务反馈表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 核查业务反馈表
	 * @param pset
	 * @return
	 */
	public EnsureToClient get(String ensureId);

	/**
	 * 增加 核查业务反馈表
	 * @param ensureToClient
	 */
	@Trans
	public void insert(EnsureToClient ensureToClient);
	
	/**
	 * 修改 核查业务反馈表
	 * @param ensureToClient
	 */
	@Trans
	public void update(EnsureToClient ensureToClient);
	
	/**
	 * 删除 核查业务反馈表
	 * @param ensureId
	 */
	@Trans
	public void delete(String ensureId);
	
	
	//查询核对参考标准
		public DataSet queryInfo(ParameterSet pset);
		
		
	//核对婚姻信息
	public DataSet queryMarryInfo(ParameterSet pset);
	
	//导入核查信息
	@Trans
	public void importXML(ParameterSet pset);
	
	
	//查询疑似信息
	public DataSet querySuspectInfo(ParameterSet pset);
	@Trans
	//批量更新
	public void batchUpdate(List list);

}