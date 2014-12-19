package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptRegularInformationCueDao;
import com.inspur.cams.bpt.base.data.BptRegularInformationCue;
import com.inspur.cams.bpt.base.domain.IBptRegularInformationCueDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;

/**
 * 定期提示
 */
public class BptRegularInformationCueDomain implements IBptRegularInformationCueDomain{
	@Reference
	IBptRegularInformationCueDao bptRegularInformationCueDao;
	
	/**
	 * 查询
	 */
	public DataSet query(ParameterSet pset){
		return bptRegularInformationCueDao.query(pset);
	}
	
	/**
	 *确认一条定期提示
	 */
	public void update(BptRegularInformationCue bptRegularInformationCue){
		bptRegularInformationCue.setConfirmFlag("1");
		bptRegularInformationCue.setConfirmTime(DateUtil.getTime());
		bptRegularInformationCue.setConfirmPeosonId(BspUtil.getEmpOrganId());
		bptRegularInformationCueDao.update(bptRegularInformationCue);
	}
	
	/**
     * 查詢定期提示
     */
    public DataSet queryRegularInforCue(ParameterSet pset){
    	return bptRegularInformationCueDao.queryRegularInforCue(pset);
    }
    /**
     * 批量删除
     * @param delIds
     */
    public void batchDelete(String[] delIds){
    	bptRegularInformationCueDao.batchDelete(delIds);    	
    }	
}