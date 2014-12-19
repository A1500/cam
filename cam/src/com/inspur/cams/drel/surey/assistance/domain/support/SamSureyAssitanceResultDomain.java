package com.inspur.cams.drel.surey.assistance.domain.support;

import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.surey.assistance.dao.ISamSureyAssistanceResultDao;
import com.inspur.cams.drel.surey.assistance.domain.ISamSureyAssistanceResultDomain;


public class SamSureyAssitanceResultDomain implements ISamSureyAssistanceResultDomain {
	@Reference
	ISamSureyAssistanceResultDao samSureyAssitanceResultDao;
}
