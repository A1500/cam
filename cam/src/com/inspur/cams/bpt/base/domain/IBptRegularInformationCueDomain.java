package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptRegularInformationCue;

/**
 * 定期提示Domain接口
 *
 */
public interface IBptRegularInformationCueDomain {
	
	/**
	 * 查询
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 添加（确认）一条定期提示
	 */
	public void update(BptRegularInformationCue bptRegularInformationCue);
	
	/**
     * 查詢定期提示
     */
    public DataSet queryRegularInforCue(ParameterSet pset);
    /**
     * 批量删除
     * @param delIds
     */
    public void batchDelete(String[] delIds);	
}