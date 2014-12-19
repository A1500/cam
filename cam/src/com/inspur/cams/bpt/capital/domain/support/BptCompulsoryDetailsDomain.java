package com.inspur.cams.bpt.capital.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.capital.dao.IBptCompulsoryDetailsDao;
import com.inspur.cams.bpt.capital.data.BptCompulsoryDetails;
import com.inspur.cams.bpt.capital.domain.IBptCompulsoryDetailsDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title 优待金发放发放名册 Domain 层
 */

public class BptCompulsoryDetailsDomain implements IBptCompulsoryDetailsDomain {
    
	@Reference
	private IBptCompulsoryDetailsDao bptCompulsoryDetailsDao;
	
	/**
	 * 优待金修改数据集
	 */
	public DataSet queryCompulsoryUpdate(ParameterSet pset){
		return bptCompulsoryDetailsDao.queryCompulsoryUpdate(pset);
	}
	
	/**
	 * query方法
	 */
	public DataSet query(ParameterSet pset){
		return bptCompulsoryDetailsDao.query(pset);
	}
	
	/**
	 * 查询义务兵优待金明细
	 */
	public DataSet queryCompulDetail(ParameterSet pset){
		return bptCompulsoryDetailsDao.query(pset);
	}
	
	/**
	 * 添加义务兵优待金明细
	 */
	public void addCompulDetail(BptCompulsoryDetails compulsoryDetails){
		compulsoryDetails.setRegDetailId(IdHelp.getUUID32());
		compulsoryDetails.setRegId(BspUtil.getEmpOrganId());
		compulsoryDetails.setRegTime(DateUtil.getTime());
		bptCompulsoryDetailsDao.insert(compulsoryDetails);
	}
	
	/**
	 * 修改义务兵优待金明细
	 */
	public void updateCompulDetail(BptCompulsoryDetails compulsoryDetails){
		compulsoryDetails.setModId(BspUtil.getEmpOrganId());
		compulsoryDetails.setModTime(DateUtil.getTime());
		bptCompulsoryDetailsDao.update(compulsoryDetails);
	}
	
	/**
	 * 查询义务兵优待金发放列表
	 */
	public DataSet queryCompulsoryGrantList(ParameterSet pset){
		return bptCompulsoryDetailsDao.queryCompulsoryGrantList(pset);
	}
	
	/**
	 * 删除义务兵优待金发放记录
	 */
	public void deleteCompulsoryDetail(String[] delIds){
		bptCompulsoryDetailsDao.batchDelete(delIds);
	}
	
	/**
	 * 除义务兵家庭外其他优抚对象优待金发放添加生成明细
	 */
	public void queryNonCompulsoryGenerateData(ParameterSet pset){
		bptCompulsoryDetailsDao.queryNonCompulsoryGenerateData(pset);
	}
	
	/**
	 * 批量添加除义务兵家庭外其他优抚对象优待金发放
	 */
	public void batchAddOfNonCompulsory(List<BptCompulsoryDetails> list) {
		bptCompulsoryDetailsDao.batchInsert(list);
	}
	
	/**
	 * 批量更新除义务兵家庭外其他优抚对象优待金
	 */
	public void batchUpdateNonCompulsory(List<BptCompulsoryDetails> list){
		bptCompulsoryDetailsDao.batchUpdate(list);
	}
	
	/**
	 * 新增优待金（非义务兵）发放对象
	 */
	public DataSet getNewCompulsoryGrantObject(ParameterSet pset){
		return bptCompulsoryDetailsDao.getNewCompulsoryGrantObject(pset);
	}
}
