package com.inspur.cams.bpt.bptrecuperate.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperate;
import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperateDetail;

public interface IBptRecuperateDomain {
    /**
     * 添加轮养休养批次
     */
    public void addBptRecuperateBatch(BptRecuperate batch);
    
    /**
     * 修改轮养休养批次
     */
    public void modifyBptRecuperateBacth(BptRecuperate batch);
    
    /**
     * 删除轮养休养批次
     */
    @Trans
    public void removeBptRecuperateBatch(String[] batchId);
    /**
     * 添加轮养休养名单
     */
    @Trans
    public void addBptRecuperateDetail(String batchId,List<BptRecuperateDetail> details,List<BptRecuperateDetail> updateDetails);
    
    /**
     * 查看批次明细
     * @return
     */
    public DataSet viewBptRecuperateDetail(ParameterSet pset);
    
    /**
     * 批量删除名单
     * @param ids
     */
    @Trans
    public void deleteDetails(String batchId,String[] ids);
    
    /**
     * 修改明细休养地点
     */
    
    public void updateDetailPlace(List<BptRecuperateDetail> details);
    
    /**
     * 查询轮养修养人员
     * @param pset
     */
    public DataSet query(ParameterSet pset);
}
