package com.inspur.cams.drel.samu.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.samu.data.SamGeroKeptPerson;

/**
 * 供养对象信息表domain
 * @author 
 * @date 2012-10-24
 */
public interface ISamGeroKeptPersonDomain {

	/**
	 * 查询 供养对象信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 获取 供养对象信息表
	 * @param pset
	 * @return
	 */
	public SamGeroKeptPerson get(String personId);

	/**
	 * 增加 供养对象信息表
	 * @param samGeroKeptPerson
	 */
	@Trans
	public void insert(SamGeroKeptPerson samGeroKeptPerson);
	
	/**
	 * 修改 供养对象信息表
	 * @param samGeroKeptPerson
	 */
	@Trans
	public void update(SamGeroKeptPerson samGeroKeptPerson);
	
	/**
	 * 删除 供养对象信息表
	 * @param personId
	 */
	@Trans
	public void delete(String personId);
	
	/**
	 * 保存供养对象信息表，同时插入业务表及更新五保人员信息表是否在院状态
	 * @param personId
	 */
	@Trans
	public void insertAll(Record[] recordPerson,Record[] recordApply,Record[] recordPeople);
	
	/**
	 * 出院业务，并更新信息表
	 * @param personId
	 */
	@Trans
	public void outGero(Record recordPerson,Record recordApply);
	/**
	 * 维护查体名册时，增加时查询不在查体名册的人员
	 * @param pset
	 * @return
	 */
	public DataSet queryInsertPerson(ParameterSet pset);
	//查询入出院供养对象列表
	public DataSet queryInoutList(ParameterSet pset);
	//统计五保供养对象信息表
	public DataSet reportSupportInfo(ParameterSet pset);
	//入出院记录信息查询表
	public DataSet queryInoutRecord(ParameterSet pset);
}