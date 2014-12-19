package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptRegularInformationCue;

/**
 * @title:IBptRegularInformationCueDao
 * @description:定期信息提示
 * @author:
 * @since:2011-06-03
 * @version:1.0
*/
 public interface IBptRegularInformationCueDao extends BaseCURD<BptRegularInformationCue>{
	public void save(List<BptRegularInformationCue> list);
	
	/**
     * 查詢定期提示
     */
    public DataSet queryRegularInforCue(ParameterSet pset);
}

