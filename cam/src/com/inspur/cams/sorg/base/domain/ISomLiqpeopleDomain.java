package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomLiqpeople;

/**
 * 社会组织清算组织人员domain接口
 * 
 * @author Muqi
 * @date 2011年5月17日19:17:21
 */
public interface ISomLiqpeopleDomain {
	/**
	 * 查询社会组织清算组织人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织清算组织人员信息
	 * 
	 * @param dataBean
	 */
	@Trans
	public void insert(SomLiqpeople dataBean);
	
	/**
	 * 删除社会组织清算组织人员
	 * 
	 * @param dataBean
	 */
	@Trans
	public void delete(String id);
	
	/**
	 * 更新社会组织清算组织人员
	 * 
	 * @param dataBean
	 */
	@Trans
	public void update(SomLiqpeople dataBean);

	/**
	 * 批量增加社会组织清算组织人员
	 * 
	 * @param lists
	 */
	@Trans
	public void batchInsert(List<SomLiqpeople> lists);

	/**
	 * 批量更新社会组织清算组织人员
	 * 
	 * @param lists
	 */
	@Trans
	public void batchUpdate(List<SomLiqpeople> lists);

	/**
	 * 批量增加社会组织清算组织人员
	 * 
	 * @param lists
	 */
	@Trans
	public void save(List<SomLiqpeople> lists);

	/**
	 * 根据sorgId，删除社会组织清算组织人员
	 * 
	 * @param sorgId
	 */
	@Trans
	public void deleteBySorgId(String sorgId);
}
