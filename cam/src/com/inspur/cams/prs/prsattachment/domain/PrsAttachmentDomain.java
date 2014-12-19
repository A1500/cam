package com.inspur.cams.prs.prsattachment.domain;

import java.util.List;
import java.util.Map;

import org.osoa.sca.annotations.Reference;

import com.inspur.cams.prs.prsattachment.dao.IPrsAttachmentDao;
import com.inspur.cams.prs.prsattachment.dao.PrsAttachment;

public class PrsAttachmentDomain implements IPrsAttachmentDomain{

		@Reference
		private IPrsAttachmentDao prsAttachmentDao;

		public void insert(PrsAttachment bean) {
			prsAttachmentDao.insert(bean);
		}

		public void update(PrsAttachment bean) {
			prsAttachmentDao.update(bean);
			
		}

		public List<Map<String, Object>> queryByPoliciesId(String policiesId) {
			return prsAttachmentDao.queryByPoliciesRegId(policiesId);
		}
		
		
}
