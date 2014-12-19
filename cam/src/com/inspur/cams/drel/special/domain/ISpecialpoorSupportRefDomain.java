package com.inspur.cams.drel.special.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.special.data.SpecialpoorSupportRef;

/**
 * 帮扶关系表domain
 * 
 * @author
 * @date 2013-08-12
 */
public interface ISpecialpoorSupportRefDomain {

	/**
	 * 查询 帮扶关系表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 帮扶关系表
	 * 
	 * @param pset
	 * @return
	 */
	public SpecialpoorSupportRef get(String recordId);

	/**
	 * 增加 帮扶关系表
	 * 
	 * @param specialpoorSupportRef
	 */
	@Trans
	public void insert(SpecialpoorSupportRef specialpoorSupportRef);

	/**
	 * 修改 帮扶关系表
	 * 
	 * @param specialpoorSupportRef
	 */
	@Trans
	public void update(SpecialpoorSupportRef specialpoorSupportRef);

	/**
	 * 删除 帮扶关系表
	 * 
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);

	/**
	 * 查询帮扶单位与帮扶村的关系数据
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSupportRef(ParameterSet pset);

	@Trans
	public void batchInsert(List<SpecialpoorSupportRef> specialpoorSupportRefList);

	/**
	 * 查询帮扶单位指定的帮扶村数据
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorHelpVillage(ParameterSet pset);
}