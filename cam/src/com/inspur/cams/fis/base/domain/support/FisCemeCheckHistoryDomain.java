package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;

import com.inspur.cams.fis.base.dao.IFisCemeCheckHistoryDao;
import com.inspur.cams.fis.base.data.FisCemeApplyInfo;
import com.inspur.cams.fis.base.data.FisCemeCheckHistory;
import com.inspur.cams.fis.base.domain.IFisCemeCheckHistoryDomain;

/**
 * 公墓年检整改历史记录表domain
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckHistoryDomain implements IFisCemeCheckHistoryDomain {

	@Reference
	private IFisCemeCheckHistoryDao fisCemeCheckHistoryDao;

	/**
	 * 查询 公墓年检整改历史记录表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCemeCheckHistoryDao.query(pset);
	}
	/**
	 * 查询 公墓年检整改历史记录表
	 * @param pset
	 * @return
	 */
	public DataSet queryOrder(ParameterSet pset){
		return fisCemeCheckHistoryDao.queryOrder(pset);
	}
	/**
	 * 查询 通过创建时间排序
	 * @param pset
	 * @return
	 */
	public DataSet queryByCreateTime(ParameterSet pset){
		return fisCemeCheckHistoryDao.queryByCreateTime(pset);
	}
	/**
	 * 获取 公墓年检整改历史记录表
	 * @param pset
	 * @return
	 */
	public FisCemeCheckHistory get(String hisId) {
		return fisCemeCheckHistoryDao.get(hisId);
	}

	/**
	 * 增加 公墓年检整改历史记录表
	 * @param fisCemeCheckHistory
	 */
	public void insert(FisCemeCheckHistory fisCemeCheckHistory) {
		fisCemeCheckHistoryDao.insert(fisCemeCheckHistory);
	}
	
	/**
	 * 修改 公墓年检整改历史记录表
	 * @param fisCemeCheckHistory
	 */
	public void update(FisCemeCheckHistory fisCemeCheckHistory) {
		fisCemeCheckHistoryDao.update(fisCemeCheckHistory);
	}
	
	/**
	 * 删除 公墓年检整改历史记录表
	 * @param hisId
	 */
	public void delete(String hisId) {
		fisCemeCheckHistoryDao.delete(hisId);
	}
	
	/**
	 * 修改 公墓新建 流程上行意见历史记录保存
	 * @param fisCemeCheckHistory
	 */
	@Trans
	public void updateUp(String hisId,String result,String opinion){
		
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("HIS_ID",hisId);
		FisCemeCheckHistory fisCemeCheckHistory  =(FisCemeCheckHistory) fisCemeCheckHistoryDao.query(pset1).getRecord(0).toBean(FisCemeCheckHistory.class);
		
		if("13".equals(BspUtil.getOrganType())){
			//System.out.println(fisCemeCheckHistory.getCemeApplyId());
			fisCemeCheckHistory.setSecondOpinion(opinion);
			fisCemeCheckHistory.setSecondResult(result);
			fisCemeCheckHistory.setSecondTime(DateUtil.getTime());
			fisCemeCheckHistory.setSecondUnit(BspUtil.getOrganName());
			fisCemeCheckHistory.setSecondUnitId(BspUtil.getOrganCode());
		}else if("12".equals(BspUtil.getOrganType())){
			//System.out.println(fisCemeCheckHistory.getCemeApplyId());
			fisCemeCheckHistory.setSecondOpinion(opinion);
			fisCemeCheckHistory.setSecondResult(result);
			fisCemeCheckHistory.setSecondTime(DateUtil.getTime());
			fisCemeCheckHistory.setSecondUnit(BspUtil.getOrganName());
			fisCemeCheckHistory.setSecondUnitId(BspUtil.getOrganCode());
		}else if("11".equals(BspUtil.getOrganType())){
			//System.out.println(fisCemeCheckHistory.getCemeApplyId());
			fisCemeCheckHistory.setThirdOpinion(opinion);
			fisCemeCheckHistory.setThirdResult(result);
			fisCemeCheckHistory.setThirdTime(DateUtil.getTime());
			fisCemeCheckHistory.setThirdUnit(BspUtil.getOrganName());
			fisCemeCheckHistory.setThirdUnitId(BspUtil.getOrganCode());
		}
		fisCemeCheckHistoryDao.update(fisCemeCheckHistory);
	}

}