package com.inspur.cams.sorg.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomChange;

/**
 * 社会组织变更信息表dao接口
 * @author yanliangliang
 * @date 2011-7-13
 */
public interface ISomChangeDao extends BaseCURD<SomChange> {
	public void save(List<SomChange> list);

	public void deleteChange(String id);
	
	public void deleteChangeByTaskCode(String taskCode);
	
	public DataSet queryChangeInfo(ParameterSet pset);
}
