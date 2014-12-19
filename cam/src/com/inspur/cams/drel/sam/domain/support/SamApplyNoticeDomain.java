package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamApplyNoticeDao;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.domain.ISamApplyNoticeDomain;
/**
 * @title:公示结果信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamApplyNoticeDomain implements ISamApplyNoticeDomain {
	@Reference
	private ISamApplyNoticeDao samApplyNoticeDao;
	
	public void insert(SamApplyNotice samApplyNotice) {
		samApplyNoticeDao.insert(samApplyNotice);
	}

	public DataSet query(ParameterSet pset) {
		return samApplyNoticeDao.query(pset);
	}

	public void update(SamApplyNotice samApplyNotice) {
		samApplyNoticeDao.update(samApplyNotice);
	}
	
	public void delete(String noticeId) {
		samApplyNoticeDao.delete(noticeId);
	}
}
