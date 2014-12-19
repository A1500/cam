package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPetition;

/**
 * @title:IBptPetitionDao
 * @description:信访
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
 public interface IBptPetitionDao extends BaseCURD<BptPetition>{
	public void save(List<BptPetition> list);
	
	/**
	 * 查询已上传二代身份证扫描件人员
	 * @return
	 */
	public DataSet queryHaveERecordPhoto(ParameterSet pset);
}

