package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamApplyDiscussionDao;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.domain.ISamApplyDiscussionDomain;
/**
 * @title:评议结果Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamApplyDiscussionDomain implements ISamApplyDiscussionDomain {
	@Reference
	private ISamApplyDiscussionDao samApplyDiscussionDao;
	
	public void insert(SamApplyDiscussion samApplyDiscussion) {
		samApplyDiscussionDao.insert(samApplyDiscussion);
	}

	public DataSet query(ParameterSet pset) {
		return samApplyDiscussionDao.query(pset);
	}

	public void update(SamApplyDiscussion samApplyDiscussion) {
		samApplyDiscussionDao.update(samApplyDiscussion);
	}

}
