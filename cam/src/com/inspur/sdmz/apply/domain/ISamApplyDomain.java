package com.inspur.sdmz.apply.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.apply.data.SamApply;


/**
 * 业务申请
 * @author Administrator
 * @date 2011-4-23
 */
public interface ISamApplyDomain {

	/**
	 * 业务查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 办理历史业务查询
	 * @param pset
	 * @return
	 */
	public DataSet ywlsQuery(ParameterSet pset);
	
	/**
	 * 保存业务
	 * @param samapply
	 */
	@Trans
	public void saveSamApply(SamApply samapply,String area);
	
	/**
	 * 更新业务
	 * @param samapply
	 */
	@Trans
	public void updateSamApply(SamApply samapply,String area);
	
	
	
	
	/**
	 * 删除业务
	 * @param delIds
	 */
	@Trans
	public void delete(String[] delIds);

	/**
	 * 初始化插入页面
	 * @param samapply 
	 *
	 */
	@Trans
	public DataSet initInsertJsp(SamApply samapply);
	
	/**
	 * 查询上级单位
	 * 
	 * @param 
	 */
	@Trans
	public DataSet querySjdw();

	/**
	 * 查询平级单位
	 * 
	 * @param 
	 */
	@Trans
	public DataSet queryPjdw();

	/**
	 * 查询下级单位
	 * 
	 * @param 
	 */
	@Trans
	public DataSet queryXjdw();

	/**
	 * 提交审核
	 * 
	 * @param 
	 */
	@Trans
	public void tjsh(String[] delIds);
	
	/**
	 * 更新业务
	 * @param samapply
	 */
	@Trans
	public void updatebgSamApply(SamApply samapply);
	/**
	 * 回访保存
	 * @param samapply
	 */
	public void hfSave(SamApply samapply);
	
	/**
	 * 回访保存2
	 * @param samapply
	 */
	@Trans
	public void ywhf(SamApply samapply,String[] applyId);
}
