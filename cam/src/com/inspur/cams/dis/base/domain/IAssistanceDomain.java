package com.inspur.cams.dis.base.domain;

import java.util.List;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.UploadFile;

public interface IAssistanceDomain{
	public void save(ParameterSet pset, List<UploadFile> fileList);
	public void deleteBatch(ParameterSet pset);
	public void selectBatch(ParameterSet pset);
}