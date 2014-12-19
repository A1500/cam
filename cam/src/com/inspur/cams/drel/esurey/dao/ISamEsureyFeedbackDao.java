package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyFeedback;

/**
 * @title:ISamEsureyFeedbackDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyFeedbackDao extends BaseCURD<SamEsureyFeedback>{
	public void save(List<SamEsureyFeedback> list);

	public void updateCheckFlg(ParameterSet pset );
	
}

