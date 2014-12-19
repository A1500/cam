package com.inspur.cams.bpt.bptrecuperate.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.bptrecuperate.dao.IBptRecuperateDao;
import com.inspur.cams.bpt.bptrecuperate.dao.IBptRecuperateDetailDao;
import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperate;
import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperateDetail;

public class BptRecuperateDomain implements IBptRecuperateDomain {
    
    @Reference
    private IBptRecuperateDao batchDao;
    @Reference
    private IBptRecuperateDetailDao detailDaoDao;

    public void addBptRecuperateBatch(BptRecuperate batch) {
        batchDao.insert(batch);
    }

    public void addBptRecuperateDetail(String batchId, List<BptRecuperateDetail> details,List<BptRecuperateDetail> updateDetails) {
        detailDaoDao.batchInsert(details);
        batchDao.updatePeopleCount(batchId, details.size(),true);
        detailDaoDao.batchUpdate(updateDetails);
    }

    public void modifyBptRecuperateBacth(BptRecuperate batch) {
        batchDao.update(batch);
    }

    public void removeBptRecuperateBatch(String[] batchIds) {
        detailDaoDao.deleteByBatchId(batchIds);
        batchDao.batchDelete(batchIds);
    }

    public DataSet viewBptRecuperateDetail(ParameterSet pset) {
        return detailDaoDao.selectByBatchId(pset);
    }

    public void deleteDetails(String batchId,String[] ids) {
        detailDaoDao.batchDelete(ids);
        batchDao.updatePeopleCount(batchId, ids.length, false);
    }

    public void updateDetailPlace(List<BptRecuperateDetail> details) {
        detailDaoDao.batchUpdate(details);
    }
    
    /**
     * 查询轮养修养人员
     * @param pset
     */
    public DataSet query(ParameterSet pset) {
    	return detailDaoDao.query(pset);
    }

}
