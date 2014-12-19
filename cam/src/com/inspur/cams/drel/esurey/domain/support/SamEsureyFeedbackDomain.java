package com.inspur.cams.drel.esurey.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.esurey.dao.ISamEsureyFeedbackDao;
import com.inspur.cams.drel.esurey.data.SamEsureyFeedback;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFeedbackDomain;
/**
 * @title:ISamEsureySocialDomain
 * @description:经济核对_外部单位填报信息domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyFeedbackDomain implements ISamEsureyFeedbackDomain {
	@Reference
	private ISamEsureyFeedbackDao samEsureyFeedbackDao;
	
	public void batchDelete(String[] delIds) {
		samEsureyFeedbackDao.batchDelete(delIds);
	}

	public void insert(SamEsureyFeedback dataBean) {
		samEsureyFeedbackDao.insert(dataBean);
		
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyFeedbackDao.query(pset);
	}

	public void save(List<SamEsureyFeedback> list) {
		// TODO Auto-generated method stub
		samEsureyFeedbackDao.save(list);
		
	}

	public void update(SamEsureyFeedback dataBean) {
		// TODO Auto-generated method stub
		samEsureyFeedbackDao.update(dataBean);
	}
	 //更新经济核对_外部单位填报信息表中提交标志
	public void updateCheckFlg(ParameterSet pset){
		samEsureyFeedbackDao.updateCheckFlg(pset);
	}
}
