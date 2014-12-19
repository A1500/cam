package com.inspur.cams.bpt.regulations.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.regulations.data.BptRegulations;

public interface IBptRegulationDomain {
    
    /**
     * 新增法规文件
     */
    @Trans
    public void insertRegulation(ParameterSet pset,MultipartRequestWrapper wrapRequest);
    /**
     * 修改法规文件
     */
    public void update(BptRegulations regulation,MultipartRequestWrapper wrapRequest);
    /**
     * 查看问题处理
     */
    public DataSet query(ParameterSet pset);
    /**
     * 删除问题处理
     */
    @Trans
    public void batchDelete(String[] delIds);

}
