package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomCert;

/**
 * 社会组织证书dao接口
 * @author yanliangliang
 * @date 2011-5-11
 */
public interface ISomCertDao extends BaseCURD<SomCert> {
	
	public void save(List<SomCert> list);
	
}
