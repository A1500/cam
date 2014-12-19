package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomOffice;

/**
 * 社会组织内设机构domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomOfficeDomain {

	/**
	 * 查询社会组织内设机构信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织内设机构信息
	 * @param somOffice
	 */
	@Trans
	public void insert(SomOffice somOffice);
	
	/**
	 * 修改社会组织内设机构信息
	 * @param somOffice
	 */
	@Trans
	public void update(SomOffice somOffice);
	
	/**
	 * 批量增加社会组织内设机构信息
	 * @param somOffice
	 */
	@Trans
	public void batchInsert(List<SomOffice> list);
	/**
	 * 批量删除社会组织内设机构信息
	 * @param somOffice
	 */
	@Trans
	public void batchDelete(String[] ids);
	/**
	 * 删除社会组织内设机构信息
	 * @param dataBean
	 */
	@Trans
	public void delete(SomOffice somOfficeOrgan);
	
	/**
	 * 增加内设机构信息
	 * @param dataBean
	 */	
	@Trans
	public void insertOnline(SomOffice somOffice) ;
	
	/**
	 * 备案中增加内设机构信息，增加一条apply信息
	 * @param dataBean
	 */	
	@Trans
	public void insertOfficeAndApply(SomOffice somOffice) ;
	
	@Trans
	public void delByTaskCode(String taskCode);
}
