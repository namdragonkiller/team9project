package com.grepp.spring.infra.util.file;

public record FileDto(
    String originFileName,
    String renameFileName,
    String savePath
) {

}
