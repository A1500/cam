package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptApplyIntoprovinceDao;
import com.inspur.cams.bpt.base.data.BptApplyIntoprovince;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;

/**
 * @description:外省优抚人员抚恤关系迁入我省
 * @author:
 * @since:2011-07-14
 * @version:1.0
*/
 public class BptApplyIntoprovinceDomain implements IBptApplyIntoprovinceDomain {
	 @Reference
	private IBptApplyIntoprovinceDao bptApplyIntoprovinceDao;
	
	 /**
	  * 查询
	  */
	public DataSet query(ParameterSet pset){
		return bptApplyIntoprovinceDao.query(pset);
	}
	
	/**
	 * 添加一条记录
	 */
	public void insert(BptApplyIntoprovince bptApplyIntoprovince){
		bptApplyIntoprovinceDao.insert(bptApplyIntoprovince);
	}
	
	/**
	 * 修改一条记录
	 */
	public void update(BptApplyIntoprovince bptApplyIntoprovince){
		bptApplyIntoprovinceDao.update(bptApplyIntoprovince);
	}
	
	/**
	 * 查询未发起流程的外省残疾人员抚恤关系迁入我省人员信息列表
	 */
	public DataSet queryUnCommitDisaIntoprovi(ParameterSet pset){
		return bptApplyIntoprovinceDao.queryUnCommitDisaIntoprovi(pset);
	}
	
	/**
	 * 查询未提交的三属外省迁入我省信息列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependIntoprovin(ParameterSet pset) {
		return bptApplyIntoprovinceDao.queryUncommitDependIntoprovin(pset);
	}
	//**************************参战*************************************
	public DataSet queryUnCommitWarIntoprovi(ParameterSet pset){
		
		return bptApplyIntoprovinceDao.queryUnCommitWarIntoprovi(pset);
	}
	
	/**
	 * 查询未提交的外省迁入我省参试抚恤关系列表
	 * 
	 */
	public DataSet queryUncommitTestedIntoprovin(ParameterSet pset) {
		return bptApplyIntoprovinceDao.queryUncommitTestedIntoprovin(pset);
	}
	
	/**
	 * 查询其他抚恤关系外省迁入
	 * @return
	 */
	public DataSet queryIntoprovin(ParameterSet pset) {
		return bptApplyIntoprovinceDao.queryIntoprovin(pset);
	}
	/**
	 * 删除抚恤关系跨省迁入
	 * @param pset
	 * @return
	 */
	public void deleteIntoprovince(ParameterSet pset){
		
		bptApplyIntoprovinceDao.deleteIntoprovince(pset);
	}
}