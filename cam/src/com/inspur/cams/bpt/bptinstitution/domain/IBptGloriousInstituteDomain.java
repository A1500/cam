package com.inspur.cams.bpt.bptinstitution.domain;

import java.util.List;

import org.loushang.next.data.*;

import com.inspur.cams.bpt.bptinstitution.data.BptGloriousInstitute;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal;


/**
 * @title:IBptGloriousInstituteDomain
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 public interface IBptGloriousInstituteDomain {

   public void saveBptGloriousInstitute(List<BptGloriousInstitute> list);
	public void saveBptGloriousLegal(List<BptGloriousLegal> list);
	public DataSet queryBptGloriousLegal(ParameterSet pset);
	public void saveBptGloriousLegalList(BptGloriousInstitute bptgloriousinstitute, List<BptGloriousLegal> list);

	

	public DataSet queryBptGloriousInstitute(ParameterSet pset);

	public DataSet getMaxYear(ParameterSet pset); 
	public void delete(List<String> list);
	public void gloriousDelete(String[] list);

 }